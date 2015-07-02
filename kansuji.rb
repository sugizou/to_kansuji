# coding: utf-8

class String

  KANSUJI_STR = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
  KANSUJI_PLACE = [nil, "十", "百", "千"]
  KANSUJI_UNIT = [nil, "万", "億", "兆", "京", "垓", "𥝱", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祇", "那由他", "不可思議", "無量大数"]

  def to_number
    total = num = t = 0
    str = check = self
    
    while (str && str.size > 0) do
      (KANSUJI_STR + KANSUJI_PLACE + KANSUJI_UNIT).uniq.compact.each do |s|
        if str =~ /^#{s}/
          str = str.slice(s.size, str.size - s.size)
          if KANSUJI_UNIT.include?(s)
            idx = KANSUJI_UNIT.index(s)
            num += t
            total += num * (10000 ** idx)
            num = t = 0
          elsif KANSUJI_PLACE.include?(s)
            idx = KANSUJI_PLACE.index(s)
            num += t > 0 ? t * (10 ** idx) : (10 ** idx);
            t = 0
          elsif KANSUJI_STR.include?(s)
            t += KANSUJI_STR.index(s)
          end
        end
      end
      if str && str.size == check.size
        raise "不正な文字が含まれています: #{str}"
      end
      check = str
    end
    total += num + t
    total.to_i
  end
end

class Integer

  KANSUJI_STR = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
  KANSUJI_PLACE = ["", "十", "百", "千"]
  KANSUJI_UNIT = ["", "万", "億", "兆", "京", "垓", "𥝱", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祇", "那由他", "不可思議", "無量大数"]

  def to_kansuji
    return KANSUJI_STR[0] if self == 0

    spts = []
    self.to_s.split(//).reverse.each_slice(4){|slice| spts << slice}

    str = ""
    spts.each_with_index do |spt, j|
      s = ""
      spt.each_with_index do |sp, i|
        next if sp.to_i == 0
        s = (sp.to_i != 1 || (i == 0 || i == 3) ? KANSUJI_STR[sp.to_i] : "") + KANSUJI_PLACE[i] + s
      end

      str = s + KANSUJI_UNIT[j] + str if s != ""
    end

    str
  end
end

