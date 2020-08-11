+++
widget = "blank"  # See https://sourcethemes.com/academic/docs/page-builder/
headless = true  # This file represents a page section.
active = true  # Activate this widget? true/false
weight = 20  # Order that this section will appear.

title = "Keyple's main features"
subtitle = "Keyple makes contactless ticketing accessible"

[design]
  # Choose how many columns the section has. Valid values: 1 or 2.
  columns = "1"

[design.background]
  # Apply a background color, gradient, or image.
  #   Uncomment (by removing `#`) an option to apply it.
  #   Choose a light or dark text color by setting `text_color_light`.
  #   Any HTML color name or Hex value is valid.

  # Background color.
  # color = "navy"
  
  # Background gradient.
  # gradient_start = "DeepSkyBlue"
  # gradient_end = "SkyBlue"
  
  # Background image.
  # image = "headers/bubbles-wide.jpg"  # Name of image in `static/img/`.
  # image_darken = 0.6  # Darken the image? Range 0-1 where 0 is transparent and 1 is opaque.
  # image_size = "cover"  #  Options are `cover` (default), `contain`, or `actual` size.
  # image_position = "center"  # Options include `left`, `center` (default), or `right`.
  # image_parallax = true  # Use a fun parallax-like fixed background effect? true/false

  # Text color (true=light or false=dark).
  text_color_light = false

[design.spacing]
  # Customize the section spacing. Order is top, right, bottom, left.
  padding = ["20px", "0", "20px", "0"]

[advanced]
 # Custom CSS. 
 css_style = ""
 
 # CSS class.
 css_class = ""
+++

The goal of Keyple is to allow developers to easily implement fast and secure off-line contactless transactions (using NFC cards, mobile phones, …) based on the Calypso standard.

More specifically, Keyple is a set of open source libraries that will initially be available in Java and C++, designed on the same mutual Object-Oriented Model compatible with any terminal architecture: mobile, embedded or server and Interoperable with any smart card reader solution: standard or proprietary, local or remote.

To fully understand how Keyple works, it is important to discern two main components of contactless ticketing technology:
- **Secure Elements (SE) readers**: Readers are situated at the entrance and exit of events, venues and transport sites. For example, a smart reader could be a terminal, a portable scanning laser gun, or a swipe tablet area that is embedded into a door, vehicle or gate. Code is written for a terminal to set the parameters for allowing cards or apps to transmit ticketing information data. Sometimes in a distributed architecture system design, the code for the reader is not on the terminal, but in a cloud environment, so the reader sends the data to cloud-based architecture.  
- **Ticketing application**: This is behind-the-scenes code that is able to take the data from the smart reader terminal and, in milliseconds real-time, analyze the balance of the ticket, confirm the permissions for entry, and update the data on the ticket (for example, to confirm that the ticket holder can enter the gate or vehicle, and then to deduct the cost of the journey and calculate the new balance).

**According to this scheme, Keyple defines two layers:**
- **SE readers** are integrated through plugins implementing the SE Proxy API which manages the communications with a contactless secure element through ant type of contactless reader (local, remote, standard, proprietary…)
- **Ticketing applications** relies on a high-level Calypso processing API to manage Calypso commands & security features.  This API uses the SE Proxy API to communicate with the reader


Keyple comes with dedicated plugins that integrate directly with smartcard readers that have been built on standard software interfaces including PC/ SC, Android NFC, and Android OMAPI. 

In cases where there is a distributed architecture design, Keyple includes a Remote Secure Element API plugin so that a smartcard terminal can be operated remotely, as if it were local to the terminal, and ensures that robust security and speed is not sacrificed in a cloud-based system. 

The Calypso Processing API is also available as a Keyple extension. This component carries out the terminal processing element of ticketing technology. Access to Calypso’s security features are automatically managed by the Keyple extension. 
