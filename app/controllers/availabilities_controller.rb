class AvailabilitiesController < ApplicationController
  def new
  end

  def create
    @space = Space.find(params[:spaceId])
    availability_data = params["data"]
    availabilities = availability_data.values.collect do |availability|
      @space.availabilities.create(
        parse_availability(availability))
    end

    render json: "a response".to_json
  end

  def edit
    space = Space.find(params[:space_id])
    @calendar_info = get_openings(space).to_json
  end

  def update
    @space = Space.find(params[:spaceId])
    @space.availabilities.destroy_all
    availability_data = params["data"]
    availabilities = availability_data.values.collect do |availability|
      @space.availabilities.create(
        parse_availability(availability))
    end

    render json: "a response".to_json

  end
end

def parse_availability(availability)
  {start_time: parse_availability_time(DateTime.parse(availability[:start])),
  end_time: parse_availability_time(DateTime.parse(availability[:end])),
  day: DateTime.parse(availability[:start]).wday}
end

def parse_availability_time(time)
  DateTime.new(2000, 01, 01, time.hour, time.minute, time.second)
end

def get_openings(space)
  space.availabilities.all.collect do |availability|
  {"start" => DateTime.new(2014, 2, 24, availability.start_time.hour, availability.start_time.strftime("%m").to_i) + (availability.day - 1).day,
   "end" => DateTime.new(2014, 2, 24, availability.end_time.hour, availability.end_time.strftime("%m").to_i) + (availability.day - 1).day,
   "title" => "",}
  end
end