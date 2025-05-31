{% assign excludexml = site.data.info.excludexml | downcase | slice: 0 %} {% assign excludejson = site.data.info.excludejson | downcase | slice: 0 %} {% assign excludettl = site.data.info.excludettl | downcase | slice: 0 %}

Download the entire implementation guide [here](full-ig.zip)

{% unless excludexml == 'y' %} {% endunless %} {% unless excludejson == 'y' %} {% endunless %} {% unless excludettl == 'y' %} {% endunless %} {% unless excludexml == 'y' %} {% endunless %} {% unless excludejson == 'y' %} {% endunless %} {% unless excludettl == 'y' %} {% endunless %}

Artifact Definitions

[XML](definitions.xml.zip)

[JSON](definitions.json.zip)

[Turtle](definitions.ttl.zip)

Examples

[XML](examples.xml.zip)

[JSON](examples.json.zip)

[Turtle](examples.ttl.zip)
