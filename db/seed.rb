require_relative '../models/address_book'
require_relative '../models/entry'
require 'bloc_record'

BlocRecord.connect_to('db/address_bloc.sqlite')

book = AddressBook.create(name: 'My Address Book')

puts 'Address Book created'
puts 'Entry created'
puts Entry.create(address_book_id: book.id, name: 'Foo One', phone_number: '999-999-9999', email: 'foo_one@gmail.com' )
puts Entry.create(address_book_id: book.id, name: 'Foo Two', phone_number: '111-111-1111', email: 'foo_two@gmail.com' )
puts Entry.create(address_book_id: book.id, name: 'Foo Three', phone_number: '222-222-2222', email: 'foo_three@gmail.com' )


puts "\n\nfind_by\n"
puts Entry.find_by(:name, "Foo One")
puts"\n\nfind_by_name\n"
puts Entry.find_by_name("Foo One")
puts "\n\nfind_each\n"
Entry.find_each(start: 1, batch_size: 10) do |row|
    puts row
end
puts "\n\nfind_in_batches\n"
Entry.find_in_batches(0,3) do |contacts|
  contacts.each { |contact| puts "this is contact #{contact}" }
end

puts "\n\nthis is order \n"
puts Entry.order(:name,  phone_number: :desc)

puts "\n\nthis is join \n"
puts Entry.join(comments: :guest)