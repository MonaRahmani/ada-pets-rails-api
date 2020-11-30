require "test_helper"

describe PetsController do
  it "must get index" do
    get pets_path
    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

end
