---
title: Adopters & Testimonials
type: landing

sections:
  - block: features
    id: adopters
    content:
      title: Eclipse Keyple® Adopters
      subtitle:
      text: '<script src="//iot.eclipse.org/assets/js/eclipsefdn.adopters.js"></script>
            <script>
                eclipseFdnAdopters.getList({ 
                    project_id: "iot.keyple", 
                    selector: ".eclipsefdn-adopters", 
                    ul_classes: "list-inline keyple-adopters", 
                    logo_white: false
                });
            </script>
            <div class="eclipsefdn-adopters"></div>
            <a href="https://iot.eclipse.org/adopters/">Follow this link to discover how to be listed as an adopter of Eclipse Keyple®</a>'
  - block: portfolio
    id: testimonials
    content:
      title: Testimonials
      subtitle:
      text: "Eclipse Keyple is a truly free and open solution. It is not possible for the team to know the scope of usage and deployment. A great way to support us and promote the project is simply to share your experience of the solution.
            {{% callout note %}}
            To add your testimonial please 
            [create an issue](https://github.com/eclipse-keyple/keyple-website/issues/new?labels=testimonial&template=testimonial.yml&title=Testimonial+Submission) on GitHub 
            **and/or** directly contribute to this website using the 
            [contribution guide]({{< relref \"community/contributing/\" >}}).
            {{% /callout %}}"
      filters:
        # Folders to display content from
        folders:
          - testimonials
        # Only show content with these tags
        tags: ["Authority", "Operator", "System integrator", "Terminal manufacturer", "Card manufacturer", "Access control / Validation", "Card inspection", "Rights loading", "Personalization", "Embedded local reader", "Distributed remote reader"]
        # Exclude content with these tags
        exclude_tags: []
        # Which Hugo page kinds to show (https://gohugo.io/templates/section-templates/#page-kinds)
        kinds:
          - page
      # Field to sort by, such as Date or Title
      sort_by: 'Title'
      sort_ascending: true
      # Default portfolio filter button
      # 0 corresponds to the first button below and so on
      # For example, 0 will default to showing all content as the first button below shows content with *any* tag
      default_button_index: 0
      # Filter button toolbar (optional).
      # Add or remove as many buttons as you like.
      # To show all content, set `tag` to "*".
      # To filter by a specific tag, set `tag` to an existing tag name.
      # To remove the button toolbar, delete the entire `buttons` block.
      buttons:
        - name: All
          tag: '*'
        - name: Authority
          tag: Authority
        - name: Operator
          tag: Operator
        - name: System integrator
          tag: System integrator
        - name: Terminal manufacturer
          tag: Terminal manufacturer
        - name: Card manufacturer
          tag: Card manufacturer
        - name: Access control / Validation
          tag: Access control / Validation
        - name: Card inspection
          tag: Card inspection
        - name: Rights loading
          tag: Rights loading
        - name: Personalization
          tag: Personalization
        - name: Embedded local reader
          tag: Embedded local reader
        - name: Distributed remote reader
          tag: Distributed remote reader
    design:
      # See Page Builder docs for all section customization options.
      # Choose how many columns the section has. Valid values: '1' or '2'.
      columns: '1'
      # Choose a listing view
      view: masonry
      # For Showcase view, flip alternate rows?
      flip_alt_rows: false
---