require "test_helper"

describe PetsController do
  it "must get index" do
    get pets_index_url
    must_respond_with :success
  end

end
