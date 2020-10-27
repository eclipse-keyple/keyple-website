+++
widget = "featurette" 
headless = true 
active = true 
weight = 40 

title = "Who uses Eclipse Keyple™?"
subtitle = "Add your logo as [adopter/user](https://iot.eclipse.org/adopters/) of Eclipse Keyple™ to this list."

[design]
  columns = "1"

[design.background]
  image = "homepage-background.png" 
  image_darken = 0 
  image_size = "cover" 
  image_position = "center"
  image_parallax = false 

  text_color_light = false

[design.spacing]
  padding = ["20px", "0", "20px", "0"]
+++

<script src="//iot.eclipse.org/assets/js/eclipsefdn.adopters.js"></script>

<script>
  eclipseFdnAdopters.getList({
    project_id: "iot.keyple",
    selector: ".eclipsefdn-adopters",
    ul_classes: "list-inline keyple-adopters",
    logo_white: false
  });
</script>

<div class="eclipsefdn-adopters"></div>
