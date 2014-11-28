class CaskParser
  def self.remove_comments(str)
    str.gsub(/;.+$/, '')
  end

  def initialize(text)
    @text = self.class.remove_comments(text)
  end

  def configuration?
    !@text.match(/\(\s*package/)
  end

  def dependencies
    @text.scan(/\(\s*depends-on\s+"(.+?)"/).flatten.uniq
  end
end
