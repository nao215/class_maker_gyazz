require "class_maker_gyazz/version"

module ClassMakerGyazz

  class Make

    attr_accessor :html
    
    def initialize text
      before_depth, current_depth, next_depth = 0
      rows = text.split("\n")
      html = rows.map.with_index do |m, i|
        puts "current #{current_depth}, next_depth #{next_depth}, before_depth #{before_depth}"
        prefix = "<li>"
        suffix = "</li>"
        current_depth = m.length - m.lstrip.length
        next_depth = rows[i + 1].length - rows[i + 1].lstrip.length unless rows.last == m
        suffix = "" if next_depth > current_depth # next row will start nest
        prefix = "<ul><li>" if before_depth < current_depth # nest start
        suffix = "#{suffix}#{'</li></ul>' * (current_depth - next_depth)}" if current_depth > next_depth # nest end
        before_depth = current_depth
        "#{prefix}#{m}#{suffix}"
      end
      @html = "<ul>#{html.join}</ul>"
    end
  end

end
