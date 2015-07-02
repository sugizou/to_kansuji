# coding: utf-8

class String

  KANSUJI_STR = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
  KANSUJI_PLACE = [nil, "十", "百", "千"]
  KANSUJI_UNIT = [nil, "万", "億", "兆", "京", "垓"]

  def to_num
    spt = self.split(//)
    total = num = t = 0

    spt.each do |s|
      if KANSUJI_UNIT.include?(s)
        idx = KANSUJI_UNIT.index(s)
        num += t
        total += num * (10000 ** idx)
        num = t = 0
      elsif KANSUJI_PLACE.include?(s)
        idx = KANSUJI_PLACE.index(s)
        num += t > 0 ? t = t * (10 ** idx) : (10 ** idx);
        t = 0
      elsif KANSUJI_STR.include?(s)
        t += KANSUJI_STR.index(s)
      end

      total += num + t if spt.last == s
    end
    total.to_i
  end
end

class Fixnum

  KANSUJI_STR = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
  KANSUJI_PLACE = ["", "十", "百", "千"]
  KANSUJI_UNIT = ["", "万", "億", "兆", "京", "垓"]

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

      str = s + KANSUJI_UNIT[j] + str
    end

    str
  end
end

