RSpec.shared_examples "required_fields" do |field|
  it "is not valid without #{field}" do
    subject.send("#{field}=", nil)
    expect(subject).not_to be_valid
    expect(subject.errors[field.to_sym]).to include("can't be blank")
  end
end