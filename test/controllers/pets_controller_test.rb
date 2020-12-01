require "test_helper"

describe PetsController do
  REQUIRED_PET_ATTRS = ["id", "name", "specious", "age", "owner"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do

    it "must get index" do
      get pets_path

      # must_respond_with :success
      # expect(response.header['Content-Type']).must_include 'json'
      check_response(expected_type: Array)
    end

    it "will return all the proper fieldsfor a list of pets" do

      get pets_path

      body = check_response(expected_type: Array)

      body.each do |pet|
        expect(pet).must_be_instance_of Hash
        expect(pet.keys.sort).must_equal REQUIRED_PET_ATTRS
      end
    end

    it "return an empty arr if no pets" do
      Pet.destroy_all

      get pets_path

      # body = JSON.parse(response.body)
      body = check_response(expected_type: Array)
      expect(body.length).must_equal 0
    end
  end

  describe "show" do
    it "will return hash with proper fields for an existinf pet" do
      pet = pets(:topol)

      get pet_path(pet.id)

      must_respond_with :success

      body = JSON.parse(response.body)
      expect(response.header['Content-Type']).must_include 'json'

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal REQUIRED_PET_ATTRS
    end

    it "will return 404 request with json for non-existent pet" do
      get pet_path(-1)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'not found'
    end

    describe "create" do
      let(:pet_params) {
        {
            pet: {
                name: "test_name",
                species: "Dog",
                age: 13,
                owner: "test_owner"
            }
        }
      }

      it "can create new pet" do
        expect{ post pets_path, params: pet_params }.must_differ "Pet.count", 1
        must_respond_with :created
      end

      it "give bad request status when user gives bad data " do
        pet_params[:pet][:name] = nil

        expect { post pets_path, params: pet_params }.wont_change "Pet.count"

        must_respond_with :bad_request

        expect(response.header['Content-Type']).must_include 'json'
        body = JSON.parse(response.body)
        expect(body["errors"].keys).must_include "name"
      end

    end

  end






end
