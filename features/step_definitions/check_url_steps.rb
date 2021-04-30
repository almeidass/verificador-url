# frozen_string_literal: true

Dado('que eu carregue as URLs') do
  @data = []
  CSV.foreach('data/urls.csv', headers: true) do |row|
    @data << row
  end
end

Quando('eu acesso a URL {string}') do |url|
  visit(url)
end

Quando('eu acesso as URLs') do
  @data.each do |row|
    puts 'row', row.inspect
    step("eu acesso a URL \"#{row['url']}\"")
  end
end

Entao('a página deve ser exibida') do
  puts('Sucesso!')
end
