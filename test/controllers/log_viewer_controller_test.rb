require "test_helper"

class LogViewerControllerTest < ActionDispatch::IntegrationTest
  # IMPORTANT: For my tests I made a parallel directory to this project in /var/logs with a file named blah.txt
  test "return Exception" do
    assert_raises Exception do
      get '/logs', params: {
        "filename": "boo.txt",
      }
    end
  end

  test "return Exception due to empty filename" do
    assert_raises Exception do
      get '/logs', params: {
        "filename": "",
      }
    end
  end

  test "return Success" do
    get '/logs', params: {
      "filename": "blah.txt",
    }

    assert_response :success
    assert_not_empty @response.parsed_body["data"]
  end

  test "testing limit" do
    get '/logs', params: {
      "filename": "blah.txt",
      "limit": 50
    }

    assert_response :success
    assert_equal 50, @response.parsed_body["data"].length
  end


  test "testing limit higher than file size" do
    get '/logs', params: {
      "filename": "blah.txt",
      "limit": 5000
    }

    assert_response :success
    assert_not_empty @response.parsed_body["data"]
  end

  test "testing keywords none found" do
    get '/logs', params: {
      "filename": "blah.txt",
      "keywords": [
        "apple"
      ]
    }

    assert_response :success
    assert_equal 0, @response.parsed_body["data"].length
  end

  test "testing keywords 1 found" do
    get '/logs', params: {
      "filename": "blah.txt",
      "keywords": [
        "appl"
      ]
    }

    assert_response :success
    assert_equal 1, @response.parsed_body["data"].length
  end

  test "testing all 3 params 1 found" do
    get '/logs', params: {
      "filename": "blah.txt",
      "keywords": %w[mailslot_send rsvp],
      "limit":50
    }

    assert_response :success
    assert_equal 50, @response.parsed_body["data"].length
  end
end
