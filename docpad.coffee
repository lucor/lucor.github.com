# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

  # Plugins configurations
  plugins:
    ghpages:
      deployRemote: 'origin'
      deployBranch: 'master'
      environment: 'static'
    navlinks:
      collections:
        posts: -1

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site: {

      services:
        disqus: 'lucasforge'
        twitterTweetButton: 'lucacorbo'
        googleAnalytics: 'UA-7923298-3'


			# The production url of our website
			url: "http://lucor.github.io"

			# Here are some old site urls that you would like to redirect from
			oldUrls: []

			# The default title of our website
			title: "Luca's Forge"

			# The website description (for SEO)
			description: """
        Experiments from the land of open source.
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				luca corbo, blog, opensource, php, javascript, coffeescript, linux, tutorial, ruby, nginx
				"""

			# The website author's name
			author: "Luca Corbo"

			# The website author's email
			email: "lu.corbo@gmail.com"

			# Styles
			styles: [
				"http://yui.yahooapis.com/pure/0.2.0/pure-min.css"
        "http://fonts.googleapis.com/css?family=Open+Sans"
				"/styles/style.css"
				"/styles/idea.css"
			]

    }


  # -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			return @site.keywords.concat(@document.keywords or []).join(', ')

	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		#pages: (database) ->
		#	database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

		posts: (database) ->
			database.findAllLive({layout:$has:'post'}, [date:-1])

  # =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad
}


# Export our DocPad Configuration
module.exports = docpadConfig


# Convert a string to a color
# @see http://stackoverflow.com/questions/3426404/create-a-hexadecimal-colour-based-on-a-string-with-jquery-javascript
String::toColor = () ->
  hash = 0
  colour = "#"

  for i in [0..this.length-1]
    hash = this.charCodeAt(i++) + ((hash << 5) - hash)
  for i in [0..2]
    colour += ("00" + ((hash >> i++ * 8) & 0xFF).toString(16)).slice(-2)

  return colour

Date::getMonthName = () ->
  months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]
  months[this.getMonth()]
