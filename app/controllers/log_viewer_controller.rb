class LogViewerController < ApplicationController

  def logs
    filename = params[:filename]

    location = filepath(filename)
    raise Exception.new "File Not Found" unless File.exist?(location)
    json_response(get_lines(
                    filepath: location,
                    keywords: params[:keywords],
                    limit: params[:limit].to_i))
  end

  private
  def get_lines(filepath: string, keywords: nil, limit: nil)
    return IO.foreach(filepath).reverse_each.to_a if keywords.nil? && limit == 0
    return IO.foreach(filepath).reverse_each.lazy.grep(/^.*(#{keywords.join('|')}).*$/).to_a if limit == 0
    return IO.foreach(filepath).reverse_each.take(limit).to_a if keywords.nil?

    IO.foreach(filepath).reverse_each.lazy.grep(/^.*(#{keywords.join('|')}).*$/).take(limit).to_a
  end

  def filepath(filename)
    current = File.dirname(__FILE__)
    dir = File.join(current, '../../../')
    path = File.join(dir,"var/log/")
    path+filename
  end

  def json_response(array)
    render json: {
      status: :ok,
      data: array
    }
  end
end
