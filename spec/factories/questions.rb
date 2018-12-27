FactoryBot.define do
    factory :question do
      question { '日本一高い山は？' }
      answer { '富士山' }
      hint { '漢字三文字です' }
      comment { '静岡県と山梨県にまたがる活火山で標高は3776mです。2番目は山梨県にある北岳で3193mです。' }
    end
  end