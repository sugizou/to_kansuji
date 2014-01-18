class Integer
  def to_kansuji
    num_str1 = ["", "十", "百", "千"]
    num_str2 = ["一", "十", "百", "千"]
    num_str3 = ["", "万", "億", "兆", "京", "垓", "秭", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祗", "那由他", "不可思議", "無量大数"]

    string = ""
    self.to_s.reverse.chars.each_slice(4).to_a.each_with_index do |chars, j|
      str = chars.each_with_index.map { |c, i|
        idx = c.to_i
        "#{["", num_str2[i], "二", "三", "四", "五", "六", "七", "八", "九"][idx]}#{num_str1[i] if idx > 1}"
      }.reverse.join
      string.insert(0, str + num_str3[j])
    end
    string
  end
end
