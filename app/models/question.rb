class Question < ApplicationRecord
  enum :answer_type, type_text: 'type text', select_one: 'select one', select_multiple: 'select many', default: :type_text
end
