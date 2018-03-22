
module Helper
  extend self
  include HTTParty

  def custom_parse(response)
    begin
      result = []
      response = response.parsed_response
      response.each do |key_out, val_out|
        if val_out.is_a?(Hash)
          val_out.each.map { |key_in, val_in| result.push({ key_in => val_in }) }
        else
          result.push({ key_out => val_out })
        end
      end
      result
    rescue => e
      p e.message
    end
  end

  def check_code(response)
    begin
      case response["code"]
      when 200
        p "200 Success"
        true
      when 400
        p "400 Bad Request" + "\n" + "The request URI does not match the APIs in the system, or the operation failed for unknown reasons. Invalid headers can also cause this error."
        false
      when 401
        p "401 Unauthorized" + "\n" + "This user is not authorized to use the API."
        false
      when 403
        p "403 Forbidden" + "\n" + "The requested operation is not permitted for the user."
        false
      else
        p response["code"] + "\n" + "Unknown error."
        false
      end
    rescue => e
      p e.message
    end
  end

end
