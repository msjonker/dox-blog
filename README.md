## Web Development Assignment

We would like to thank you for taking the time to complete this assignment. We believe this to be an effective way at allowing you to show us your skills, on your own time, without the pressure of someone looking over your shoulder. Your code will be used to help us decide if we'd like to proceed with the interview process. Please understand that completing this assignment doesn't guarantee a job or follow up interviews. We will keep you posted either way. Please reach out to jobs@doximity.com with any questions.

Note that it should take you 2-3 hours to complete this assignment.


### Setup

Run `bin/setup` and then boot the app with `rails server`

### Running Tests

Run `bundle exec rspec`

------------

## Please Read the Following Carefully

* **FORK** this repository, create a branch, complete all 3 stories and create a pull-request pointing at ****YOUR**** fork with your changes.
* Code Style Guide can be found [here](https://github.com/bbatsov/ruby-style-guide), use 2 soft-tabs.
* The tests included are very basic, better tests are encouraged particularly for logic you added.
* Please refrain from including unnecessary gems or spending time on CSS.
* Avoid pushing indentation changes to current files, this makes the changeset harder to read.
* The use any kind of JavaScript front-end enhacements is 100% optional, feel free to add as you see fit if time permits and you'd like to show your skills. One idea: in place search result suggestions.
* Once completed, email a link to your Pull Request to jobs@doximity.com


### Story 1

```
Story Title: As a reader I would like to have all articles imported so that I can read the blog.

Description: You will find a CSV file under db/data folder, write a class and seed file to handle
the importing of articles into the DB. While importing, ensure you create necessary author
records based on the content of the CSV file and associate each article to the proper author.
```

### Story 2
```
Story Title: As a reader I would like to search the blog so that I can find articles which interest me.

Description: Leverage the current sidebar HTML under 'Search Articles' to provide search functionality.
Without using a search gem provide search functionallity. Note that leveraging MySQL `like` for this
is perfectly fine. Search against article body and title.
```

### Story 3
```
Story Title: As a reader I would like my search results to be sorted by
relevancy according to my search query so that I see the most relevant
results at the top.

Description: Using a Ruby class and a simple word analyses algorithm **that you create**.
Do not use a search engine library, you need to create your own algorithm.
Incorporate this relevancy score in the sort order of the search results.
Search against article body and title. An article that contains the same
word twice would have a relevancy score that is higher than an article
which only contains the searched word once. Title of the article should
weigh relevancy more heavily.

If time permits, bonus points for performance considerations, caching and pre-calculating tokens.
```

## What to Expect after you Submit

Our team will be notified and we'll review the submission within 2 days. We'll run code analysers to check for added complexity, spec coverage, and adherednce to style. Most importantly three engineers will review your code. We're looking for clean, easy to read, maintainable code. Good test coverage, performance considerations and optimizations are a plus as well. We know your time is valuable and appreciate you taking the time to complete this assignment.
