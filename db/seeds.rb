# frozen_string_literal: true

30.times do
  body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
  Message.create body:
end
