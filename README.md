# Solution README

This solution consists of Ruby code for processing photo data provided as a CSV string. The main objective of the code is to rename the photos based on their locations and the order they were taken in, and then generate a new string with the renamed photos.

## Usage

To test this solution using rspec, simply run:

```bash
    rspec spec/solution_spec.rb
```

Example usage:
```ruby
require_relative 'solution'
# Example photo data CSV string
    photo_data = "photo.jpg, Krakow, 2013-09-05 14:08:15
    Mike.png, London, 2015-06-20 15:13:22
    myFriends.png, Krakow, 2013-09-05 14:07:13
    Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
    pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
    BOB.jpg, London, 2015-08-05 00:02:03
    notredame.png, Florianopolis, 2015-09-01 12:00:00
    me.jpg, Krakow, 2013-09-06 15:40:22
    a.png, Krakow, 2016-02-13 13:33:50
    b.jpg, Krakow, 2016-01-02 15:12:22
    c.jpg, Krakow, 2016-01-02 14:34:30
    d.jpg, Krakow, 2016-01-02 15:15:01
    e.png, Krakow, 2016-01-02 09:49:09
    f.png, Krakow, 2016-01-02 10:55:32
    g.jpg, Krakow, 2016-02-29 22:13:11"

# Call the solution function
renamed_photos = solution(photo_data)

# Print the result instead of puts so the newlines are visable
print renamed_photos
```

## Functionality
The solution consists of the following key functions:

- solution: The main function that orchestrates the renaming process.
- solution_helper: Helper function used by solution for generating the final output.
- rename_photos: Function for renaming photos within a group based on location and order.
- get_location_counts: Function to count the number of photos per location.
- new_photo_name: Function to generate a new name for each photo.
- to_photo_arr: Function to convert the CSV string into an array of photo data hashes.
- parse_location, parse_time, parse_photo_name: Functions for parsing location, time, and photo name respectively.

## Parsing Logic
The code utilizes dedicated functions for parsing despite the seeming overkill. This approach is chosen because edge cases often arise around parsing. By segregating the parsing logic into separate functions, future refactoring becomes simpler.

Please note that the code assumes a well-formatted CSV input and may raise errors for improperly formatted data.

## Note
The solution could be further extended to include more detailed error handling and additional checks for file extensions.

