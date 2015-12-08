# Foundation Walkthrough Practice

We're going to practice using Foundation via implementing a design from a wireframe. As a developer, you'll often get or make wireframes that sketch out the approximate look of a web page, like [this one](http://i.imgur.com/qBALeUA.png). (This wireframe was created using [Balsamiq](https://balsamiq.com/).)

In this tutorial, you'll use the files provided to walk through the process of creating a website that looks like this:

- [Normal view](http://i.imgur.com/qBALeUA.png)
- [Mobile view](http://i.imgur.com/J2WzwVP.png)

Do note that we are using a `layout.erb` file, as well as `index.erb`. Anything that we want to show up on *every* page - such as the page header - should be put in `layout.erb`, and page-specific content should be put in `index.erb`.

### 1. Install Foundation

Use the instructions provided in the [clinic notes](https://github.com/cmkoller/css_frameworks_winter_2015).

Make sure to also follow the instructions at the bottom for setting up use of Javascript-based features!

### 2. Make the topbar

When making a topbar, I always start by copy and pasting from Foundation's docs. Visit [http://foundation.zurb.com/docs](http://foundation.zurb.com/sites/docs/) and click "Navigation > Overview" along the side bar to view the relevant documentation.

The nav bar they show under the "Top Bar" looks pretty similar to what we're going for:

![](http://i.imgur.com/9Ohf675.png)

To use it, let's click on the "Top Bar" link along the left side of the page, and then copy and paste their code example, and edit it to suit our needs. Copy that code and paste it in `layout.erb`, right inside the opening `body` tag (and above the line that says `<%= yield %>`).

Now let's edit that code. Going piece by piece through the sample code:

```html
<div class="top-bar">
  <div class="top-bar-left">
    <ul class="dropdown menu" data-dropdown-menu>
      <li class="menu-text">Site Title</li>
```

The above section sets the title of the site. First of all, let's change "Site Title" to the actual title of our site.

If we look at this first chunk of code in a larger context:

```html
<div class="top-bar">
  <div class="top-bar-left">
    <ul class="dropdown menu" data-dropdown-menu>
      <li class="menu-text">Site Title</li>
      <li class="has-submenu">
        <a href="#">One</a>
        <ul class="submenu menu vertical" data-submenu>
          <li><a href="#">One</a></li>
          <li><a href="#">Two</a></li>
          <li><a href="#">Three</a></li>
        </ul>
      </li>
      <li><a href="#">Two</a></li>
      <li><a href="#">Three</a></li>
    </ul>
  </div>
```

This creates all the links on the left hand side of our top bar, and there's a bunch of stuff there we don't need. First of all, there are several more links shown here than we have in our designs. Second of all, Foundation has provided us with code for a dropdown menu, which is not in our designs.

Let's get rid of that extra code! Delete `li` that has a class of `has-submenu`, along with its entire contents. That's the dropdown link, we don't need that. Since we no longer have a dropdown, we can now delete the class of `dropdown` from the `ul`, along with the attribute `data-dropdown-menu`. Last of all, delete one of other two `li`s, and change the text of the last one so it matches our designs.

Next up:

```html
  <div class="top-bar-right">
    <ul class="menu">
      <li><input type="search" placeholder="Search"></li>
      <li><button type="button" class="button">Search</button></li>
    </ul>
  </div>
</div>
```

This section of code sets up contents of the right side of the top bar. Right now, it's showing a search form, which we don't want. Let's change the contents of the two `li`s so that instead of showing two form components, they each contain an `a` tag and the text shown in the designs.

Our final nav bar HTML should look like this:

![](http://i.imgur.com/K23cHNj.png)

### 3. Adding the Breadcrumbs

![](http://i.imgur.com/tqgd95I.png)

Will you look at that, Foundation has a [section on breadcrumbs](http://foundation.zurb.com/sites/docs/breadcrumbs.html)! Good stuff. They don't look exactly our wireframes, but wireframes are supposed to be approximate, so that's probably okay.

Let's grab the sample code that Foundation gives us for breadcrumbs, and customize it to look like we want it to! The code we want to use for these breadcrumbs will change depending on what page we're looking at, so let's put this code in `index.erb` instead of our `layout` file. Copy and paste Foundation's example code into `index.erb`. Next, to customize it, replace the text with our own text and make sure that there aren't any classes like `"disabled"` on any list items that they shouldn't be on.

Load the page and check it out.

![](http://i.imgur.com/GrmFZ9n.png)

Oh no! The breadcrumbs are mushed up right against the edge of the page, instead of having nice gutters like shown in the wireframe.

### 4. Constrain the width of our page content using `row`s

Luckily Foundation `row`s come with a handy feature - they have a maximum width of `62.5rem`. (`rem` is a particular type of distance measurement for web dev, similar to pixels but dynamic based on device.)

As we can see from our designs, we want *all* the rest of the content we'll be putting into our page should be constrained in width, and have these gutters at the sides. Since this will presumably apply to *every* page, let's accomplish this by putting a `row` in our `layout.erb` file. If we wrap the `row` around our `yield` statement, it'll make sure that no contents in our `index.erb` file will extend beyond the desired width.

Add the `row` to your `layout` file:

![](http://i.imgur.com/88XCdvj.png)

Now the gutters around the breadcrumbs - and all future content - should be in place when the screen gets wide.

BUT! When we make the screen not-super-huge, the breadcrumbs go right back to being pressed against the edge.

### 5. Adding some padding with `row column`s

Foundation has a nice little built-in thing where you can make a container *both* a column and a row, to get some properties of both. I like to use this for my containers that wrap around all my content, so that I get both that max-width we talk about above, and also a little bit of padding on both edges from the column.

Add the class `column` to your container that wraps around the `yield` statment:

![](http://i.imgur.com/8ipRUJx.png)

Now we should have a nicely constrained width on large screens, and a little bit of padding even on small screens.

### 6. Adding our header text

Let's add in our page headers. Below the breadcrumbs in your `index.erb` file, add the headers - I'm going to use an `h1` and an `h3`:

![](http://i.imgur.com/TCgqTkh.png)

But wait! Our text isn't centered! Luckily, Foundation has a hand [helper classes](http://foundation.zurb.com/sites/docs/typography-helpers.html) to help center text alignment. Read about it [here](http://foundation.zurb.com/sites/docs/typography-helpers.html) - adding the class `text-center` to something will try to center the text-alignment of all its contents.

This means we *could* add the class `text-center` to both our `h1` and our `h3`, and that would work fine:

![](http://i.imgur.com/88wB2LB.png)

Alternatively we could be a little more efficient, and add a `div` around both the `h1` and `h3` and put the class `text-center` on that. That will tell the div to center all its contents at once. I'm going to go with that one; here's my final code for this section:

![](http://i.imgur.com/Crk2t6P.png)

### 7. Adding the colored boxes

Foundation has handy styles pre-defined for boxes of a slightly different color than their background, which they call [callouts](http://foundation.zurb.com/sites/docs/callout.html). Looking at the documentation in the link here, we can see that making a `div` with the class of `callout` will give it a border- and adding the class `secondary` will give it that nice darker background we're looking for. Let's try that with just one box:

![](http://i.imgur.com/CSZIshr.png)

(We'll add the buttons in later.)

When we reload the page, we can see that this looks pretty good, except for one thing - the callout box is stretching all the way across the content area of our page, whereas we only want it to be taking up one third of that space (so we can fit the other two panels).

The [Foundation grid system](http://foundation.zurb.com/sites/docs/grid.html) provides us with the ability to make "columns" take up a set percentage of the width of the container they reside in. Remember that Foundation things of columns as being `?? twelfths` the width of their parent element. So in this case, we want each panel to be *4 twelfths* (aka 1/3rd) the width of their containing row. To accomplish that, we can add the classes `small-4` and `columns` to our `panel` div, in order to say: "Hey Foundation! This thing is a column, and on small screens and up, it should take up 4/12ths the width of its container".

![](http://i.imgur.com/zJLgWYZ.png)

So far so good! Now let's copy and paste that chunk of code so that we end up with three identical panels.

When we reload the page, we can see this is looking... less good. Where is the nice space between our panels?

![](http://i.imgur.com/2GMqUfs.png)

Foundation columns have padding inside them, that keeps their content from pressing up right against their edges, but they don't have any *margin* around them that keeps them from being pressed up against each other. As a solution, instead of having our `panel` be the *full size* of the column, let's move our panel to existing *inside* our column so that the padding inside the column adds some space between the panel's edges and the very edges of the column.

Now our `index.erb` file should look like this:

![](http://i.imgur.com/hfVAgGw.png)

Reload the page - much better!

### 8. Adding the button to the panel

Foundation has a nice section on how to make [pretty-looking buttons](http://foundation.zurb.com/sites/docs/button.html) - pretty much, the secret is to take a link and put the class `button` on it. So let's do that inside each of our panels:

![](http://i.imgur.com/9zO4btK.png)

When we reload the page, we can see this is close to our desired look, but the buttons are left-aligned instead of centered.

To fix this, let's first try adding the class `text-center` to the link itself:

![](http://i.imgur.com/F3KGp8Y.png)

When we reload the page, we can see that there isn't any change.

Let's "Inspect Element" on the button to get a closer look.

![](http://i.imgur.com/iRMXzVd.png)

From this view, we can see that the button is only ~145px wide. What `text-center` does is say "For this element, I want to center the alignment of all the element's contents" - but that will only center it within the width of the element itself. For the button's text to appear centered in the panel, the button element would need to be the full width of the panel, if this is the approach we're taking.

Instead, let's take a different approach: let's take our button, and wrap it in a `div` that has the class `text-center`.

![](http://i.imgur.com/OhEk17i.png)

Now, when we reload the page and inspect element, we can see this:

![](http://i.imgur.com/rzlQ1gy.png)

By default, `div`s are full-width. Therefore, when we put the class `text-center` on a div, it stretches to take up the full width of its parent, and *then* tries to center any text elements inside it. That means it successfully centers the button within our parent box.

Go ahead and add a centered button to both of the other panels on our page.

### 9. Making the panels look good on Mobile

We've set things up so that they're looking good on a large screen, but we also have those [mobile designs](http://i.imgur.com/J2WzwVP.png) we need to follow. This wireframe is showing us that on small screens, we need the panels to be the full width of the page.

To do that, we need to change the classes we have wrapped around our panels to specify that on small screens, each panel should be 12 columns wide, and on medium-to-large screens, each panel should be 4 columns wide:

![](http://i.imgur.com/zDv3Df9.png)

Reload the page, and we should be looking good.

### 10. Adding the "Resources" section and form

From here, try to use the tools we've gone over above, along with the Foundation documentation, to complete the rest of the wireframe. Specifically check out Foundation's docs on [vertical menus](http://foundation.zurb.com/sites/docs/menu.html#vertical-menu) and [forms](http://foundation.zurb.com/sites/docs/forms.html). For the form section, make good use of Foundation's grid system.

Tip: you can add a class of `button` to form submit buttons as well, to get them to look good!

Once you've gotten as far as you can, feel free to check out my final version of the code [here](https://github.com/cmkoller/foundation-tutorial-final-code).

Good luck!
