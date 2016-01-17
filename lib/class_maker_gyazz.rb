require "class_maker_gyazz/version"

module ClassMakerGyazz

  class Make

    attr_accessor :html
    
    def initialize text
      before_depth = current_depth = next_depth = 0
      rows = text.split("\n")
      html = rows.map.with_index do |m, i|
        prefix = "<li>"
        suffix = "</li>"
        current_depth = m.length - m.lstrip.length
        next_depth = rows[i + 1].length - rows[i + 1].lstrip.length unless rows.last == m
        suffix = "" if next_depth > current_depth # next row will start nest
        prefix = "<ul><li>" if before_depth < current_depth # nest start
        suffix = "#{suffix}#{'</li></ul>' * (current_depth - next_depth)}" if current_depth > next_depth # nest end
        before_depth = current_depth
        tag, end_tag = text_tag(m, current_depth, next_depth)
        "#{prefix}#{tag}#{check_text(m)}#{end_tag}#{suffix}"
      end
      @html = "<ul>#{html.join}</ul>"
    end

    def text_tag text, current_depth, next_depth
      if current_depth == 0
        tag = is_img?(text) ? "<h2>" : "<h2 class='page-header'>" 
        end_tag = "</h2>"
        return tag, end_tag
      end
    end

    def check_text text
      if is_img?(text)
        text = "<img class='img-thumbnail' src='#{clean_brackets(text)}'>"
      elsif text =~ /\[\[\[.*\]\]\]/
        text = "<strong>#{text}</strong>"
        text = check_link(clean_brackets(text))
      elsif text =~ /\[\[.*\]\]/
        text = check_link(clean_brackets(text))
      end
      text
    end

    def check_link text
      if text =~ /(http|https)\:\/\/\w.*/
        text = "#{text.gsub($&,"")}<a href='#{$&}'>#{$&}</a>"
      end
      text
    end

    def is_img? text
      text =~ /\[\[(http|https)\:\/\/\w.*(png|jpg|jpeg|gif)\]\]/
    end

    def clean_brackets text
      text.gsub(/(\[\[\[|\]\]\])/, "").gsub(/(\[\[|\]\])/, "")
    end

  end

end
