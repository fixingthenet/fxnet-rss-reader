FactoryBot.define do
  factory :fxnet_app_configuration, class: 'Fxnet::AppConfiguration' do
    identifier { "MyString" }
    configuration { "" }
  end
end
