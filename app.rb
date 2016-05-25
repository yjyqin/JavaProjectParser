# encoding: utf-8


folder = './samples/commons-io/src'

return unless Dir.exist? "#{folder}/main/java"

Dir.glob("**/*.java").each_with_index do |filename, index|

  break if index > 0

  puts "\n" + " #{filename.split('/').last} ".center(80, '-') + "\n\n"

  content = File.open(filename, 'r') { |f| f.read }
  
  shrink = content.gsub(/\/\*.*?\*\//m, '')
                  .lines
                  .reject { |line| line.strip.empty? || line.strip =~ /^\/\// }
                  .collect { |line| line.gsub(/\((,)+\)/m, '()') }
                  .join(" ").gsub(/\n/, '').gsub(/\s{2,}/, ' ')

  puts shrink.split(/;/).join("\n").gsub(/\{/, "{\n").gsub(/\}/, "}\n")
end