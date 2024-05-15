---
title: External resources
type: landing
aliases:
  - /suppliers/

sections:
  - block: portfolio
    id: external-resources
    content:
      title: External Resources
      subtitle:
      text: "{{% callout note %}}This page lists the suppliers of Keyple external resources. 
            You can filter them by the type of resource you're looking for, 
            then click on the supplier's name for more information.
            To reference your company please 
            [create an issue](https://github.com/eclipse-keyple/keyple-website/issues/new?template=external-resources-proposal.yml) on GitHub 
            **and/or** directly contribute to this website using the 
            [contribution guide]({{< relref \"community/contributing/\" >}}).
            {{% /callout %}}"
      filters:
        # Folders to display content from
        folders:
          - suppliers
        # Only show content with these tags
        tags: ["Reader plugins", "Card extensions", "Demos", "Tools", "Compliant terminals", "Training", "Development"]
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
        - name: Reader plugins
          tag: Reader plugins
        - name: Card extensions
          tag: Card extensions
        - name: Demos
          tag: Demos
        - name: Tools
          tag: Tools
        - name: Compliant terminals
          tag: Compliant terminals
        - name: Training
          tag: Training
        - name: Development
          tag: Development
    design:
      # See Page Builder docs for all section customization options.
      # Choose how many columns the section has. Valid values: '1' or '2'.
      columns: '1'
      # Choose a listing view
      view: masonry
      # For Showcase view, flip alternate rows?
      flip_alt_rows: false
---