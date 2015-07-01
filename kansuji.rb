class Integer
  def to_kansuji
    num_str1 = ["", "十", "百", "千"]
    num_str2 = ["一", "十", "百", "一千"]
    num_str3 = ["", "万", "億", "兆", "京", "垓", "𥝱", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祇", "那由他", "不可思議", "無量大数"]

    string = ""
    self.to_s.reverse.chars.each_slice(4).to_a.each_with_index do |chars, j|
      str = chars.each_with_index.map { |c, i|
        idx = c.to_i
        "#{["", num_str2[i], "二", "三", "四", "五", "六", "七", "八", "九"][idx]}#{num_str1[i] if idx > 1}"
      }.reverse.join + num_str3[j]
      string.insert(0, str) unless num_str3.include?(str)
    end
    string
  end
end

class String
  def to_number
    num_str = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九']
    num_str1 = ["", "十", "百", "千"]
    num_str3 = ["", "万", "億", "兆", "京", "垓", "𥝱", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祇", "那由他", "不可思議", "無量大数"]

    kansuji_clone = self.dup
    kansuji = []
    indexs = []
    sub_indexs = []
    i = 0

    loop do
      break unless hit_index = unit_split(kansuji_clone)

      unit = kansuji_clone[0..hit_index]

      if num_str1.index(unit)
        sub_indexs << i
      elsif num_str3.index(unit)
        indexs << { unit => sub_indexs }
        sub_indexs = []
      end

      kansuji << unit
      kansuji_clone[0..hit_index] = ''
      i += 1
    end # loop do

    kansuji << kansuji_clone unless kansuji_clone.empty?

    kansuji = kansuji.map do |unit|
      if num_str3.include?(unit)
        10**(num_str3.index(unit) * 4)
      elsif num_str1.include?(unit)
        10**num_str1.index(unit)
      elsif num_str.include?(unit)
        num_str.index(unit)
      end
    end

    indexs.each do |index|
      index.each do |key, value|
        unit_num = 10**(num_str3.index(key) * 4)
        value.each { |val| kansuji[val] = kansuji[val] * unit_num }
      end
    end

    sums = []

    loop do
      first = kansuji.delete_at(0)
      last = kansuji.delete_at(0)

      if first && last
        if first > last
          sums << first + last
        else
          sums << first * last
        end
      elsif first
        sums << first
      end

      break if kansuji.empty?
    end

    sums.inject {|sum, n| sum + n }
  end

  def unit_split(kansuji)
    num_str = ["一", '二', '三', '四', '五', '六', '七', '八', '九', "十", "百", "千", "万", "億", "兆", "京", "垓", "𥝱", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祇", "那由他", "不可思議", "無量大数"]

    unit = num_str.detect { |unit| kansuji =~ /^#{unit}/ }
    unit ? (unit.size - 1) : nil
  end

end
