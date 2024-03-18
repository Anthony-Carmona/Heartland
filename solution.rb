require 'csv'
require "time"

# Main solution function
def solution(s)
    # Convert input string to array of photo data hashes
    photo_arr = to_photo_arr(s)
    # Get counts of photos per location
    location_counts = get_location_counts(photo_arr)
    # Determine the length of the integer string needed for renaming
    integer_length = {}
    location_counts.each do |location, count|
        integer_length[location] = (count + 1).to_s.length
    end
    
    # Generate the final solution
    solution_helper(photo_arr, integer_length)
end

# Helper function for generating the solution
def solution_helper(photo_arr, integer_length)
    # Group photos by location
    grouped_photos = photo_arr.group_by { |photo| photo[:location] }
    # Map old photo names to new ones
    photo_name_mapping = {}

    grouped_photos.each do |location, photo_group|
        photo_name_mapping.merge!(rename_photos(photo_group, integer_length[location]))
    end

    # Generate the final output by mapping old names to new ones and joining with newline
    photo_arr.map { |photo| photo_name_mapping[photo[:name]] }.join("\n")
end

# Rename photos within a group
def rename_photos(photo_group, integer_length)
    # Sort the photo group by time
    photo_group = photo_group.sort_by { |photo| photo[:time] }
    photo_mapping = {}
    # Iterate over each photo and create a new name
    photo_group.length.times do |t|
        photo = photo_group[t]
        photo_mapping[photo[:name]] = new_photo_name(photo, integer_length, t)
    end
    photo_mapping
end

# Get counts of photos per location
def get_location_counts(photo_arr)
    counts = {}
    photo_arr.each do |photo|
        counts[photo[:location]] = counts[photo[:location]].to_i + 1
    end
    counts
end

# Generate a new photo name
def new_photo_name(photo, integer_length, i)
    "#{photo[:location]}#{(i + 1).to_s.rjust(integer_length, '0')}.#{photo[:extention]}"
end

# Convert input string to array of photo data hashes
def to_photo_arr(s)
    arr = []
    # Parse CSV and convert to array of hashes
    CSV.parse(s, headers: %i[photo_name location time]).each do |row|
        name, extention = parse_photo_name(row[:photo_name])
        arr.push(
            {
                name: name,
                extention: extention,
                location: parse_location(row[:location]),
                time: parse_time(row[:time])
            }
        )
    end
    arr
end

# Having dedicated functions for parsing may seem like overkill; however, from experience, edge cases always crop up around parsing.
# Thus, I am starting with the logic for parsing placed in their own functions so that refactoring will be simplified.

# Parse location string
def parse_location(parse_location)
    parse_location.strip
end

# Parse time string
def parse_time(time)
    Time.parse(time)
end

# Parse photo name and extension
def parse_photo_name(photo_name)
    photo_name = photo_name.split(".")
    if photo_name.length == 2 # should also include checks to see if the file extension is associated with any types we are willing to support
        photo_name
    else
        raise StandardError.new "unable to parse photo name" # should include more detailed errors on why the photo_name is ill formatted
    end
end
