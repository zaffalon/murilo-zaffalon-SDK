### Designer

You can add `opts` to add some headers to the request.

```ruby
# get movie by id
Elessar::Movie.retrieve(id, opts = {})

# get all movies
movie = Elessar::Movie.list(filters = {limit: 10}, opts = {})

# You can acces the data
movie.docs.first.name

# get all quotes from a movie
quote = movie.list_quotes(filters = { limit: 10 }, opts = {})

quote.docs.first.dialog

# For Custom searches you can use the filters passing the string
Elessar::Movie.list("budgetInMillions<100")
```