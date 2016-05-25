# encoding: utf-8


folder = './samples/commons-io/src'

return unless Dir.exist? "#{folder}/main/java"

def parse_header(header)
  header.split(';')
        .collect { |line| line.strip }
        .each do |line|
          case line
          when /import\s(.+)/
            puts "dep: #{$1}"
          when /package\s(.+)/
            puts "package: #{$1}"
          when /class/
            puts "class: #{line}"
          else
            puts "unknown: #{line}"
          end
        end
end

def parse_body(body)
end

Dir.glob("**/*.java").each_with_index do |filename, index|

  break if index > 2

  puts "\n" + " #{filename.split('/').last} ".center(80, '-') + "\n\n"

  content = File.open(filename, 'r') { |f| f.read }
  
  shrink = content.gsub(/\/\*.*?\*\//m, '')
                  .lines
                  .reject { |line| line.strip.empty? || line.strip =~ /^\/\// }
                  .collect { |line| line.gsub(/\((,)+\)/m, '()') }
                  .join("")
                  .gsub(/\s{2,}/, ' ')

  header, title, body = shrink.partition('{')

  parse_header header
  parse_body body.chomp('}')
end