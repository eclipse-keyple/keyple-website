+++
# A News section created with the Pages widget.
# This section displays from `content/news/` recent:
# - news
# - deployment/use cases
# - roadmap
# - releases

widget = "pages"
headless = true  # This file represents a page section.
active = true  # Activate this widget? true/false
weight = 30  # Order that this section will appear.

title = "What's new ?"
subtitle = "To add a news send your content to [user mailing list](https://accounts.eclipse.org/mailing-list/keyple-user) or made a [Pull request](https://github.com/eclipse/keyple-website/pulls) contributions on GitHub. "

[content]
  # Page type to display. E.g. post, talk, or publication.
  page_type = "post"
  
  # Choose how much pages you would like to display (0 = all pages)
  count = 5
  
  # Choose how many pages you would like to offset by
  offset = 0

  # Page order. Descending (desc) or ascending (asc) date.
  order = "desc"

  # Filter posts by a taxonomy term.
  [content.filters]
    tag = ""
    category = ""
    publication_type = ""
    author = ""
    exclude_featured = false
  
[design]
  # Toggle between the various page layout types.
  #   1 = List
  #   2 = Compact
  #   3 = Card
  #   4 = Citation (publication only)
  view = 2
  
[design.background]
  # Background image.
  image = "homepage-background.png"  # Name of image in `static/img/`.
  image_darken = 0  # Darken the image? Range 0-1 where 0 is transparent and 1 is opaque.
  image_size = "cover"  #  Options are `cover` (default), `contain`, or `actual` size.
  image_position = "center"  # Options include `left`, `center` (default), or `right`.
  image_parallax = false  # Use a fun parallax-like fixed background effect? true/false

  # Text color (true=light or false=dark).
  text_color_light = false
+++

