require 'open-uri'
require 'telegram/bot'
require 'imdb'

class Bot

  def initialize(token)
    @token = token
  end

  def get_movie(query)
    Imdb::Search.new(query).movies.first
  end

  def print_movie(movie)
    s = []
    s << "Title: #{movie.title}"
    s << "Director: #{movie.director.first}"
    s << "Cast: #{movie.cast_members[0..2].join(', ')}"
    s << "Rating: #{movie.rating}"
    s << ''
    s << movie.plot
    s << movie.url
    s.join("\n")
  end

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message.text
        when /^\/imdb\s+(.*)$/
          Thread.new do
            bot.api.sendChatAction(chat_id: message.chat.id, action: 'typing')
            movie = get_movie($1)
            if movie
              poster = movie.poster
              if poster
                f = open(poster)
                filename = "#{f.path}.jpg"
                `mv '#{f.path}' '#{filename}'`
                bot.api.sendPhoto(chat_id: message.chat.id, photo: File.new(filename)) if File.exist?(filename)
              end
              bot.api.sendMessage(chat_id: message.chat.id, text: print_movie(movie), disable_web_page_preview: true)
            end
          end
        end
      end
    end
  end

end

bot = Bot.new(ARGV.first)
bot.start
