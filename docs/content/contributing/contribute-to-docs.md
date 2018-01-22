---
title: Building the docs website
weight: 9100
---

If you want to contribute to the documentation, that is awesome! Your help is very much appreciated, but please do keep in mind the instructions below.

## Prerequisites
These documentation pages are built with [Hugo](https://gethugo.io) and we do make some assumptions:

* You have Git 2.5 or greater [installed on your machine](https://git-scm.com/downloads).
* You have a GitHub account. [Signing up](https://github.com/join) for GitHub is free.
* You have Hugo [installed](https://gohugo.io/getting-started/quick-start/) on your machine.

In **Hugo**, pages are the core of your site. Once it is configured, pages are definitely the added value to your documentation site.

## Folders

Organize your site like [any other Hugo project](https://gohugo.io/content/organization/). Typically, you will have a *content* folder with all your pages.

    content
    ├── level-one 
    │   ├── level-two
    │   │   ├── level-three
    │   │   │   ├── level-four
    │   │   │   │   ├── _index.md       <-- /level-one/level-two/level-three/level-four
    │   │   │   │   ├── page-4-a.md     <-- /level-one/level-two/level-three/level-four/page-4-a
    │   │   │   │   ├── page-4-b.md     <-- /level-one/level-two/level-three/level-four/page-4-b
    │   │   │   │   └── page-4-c.md     <-- /level-one/level-two/level-three/level-four/page-4-c
    │   │   │   ├── _index.md           <-- /level-one/level-two/level-three
    │   │   │   ├── page-3-a.md         <-- /level-one/level-two/level-three/page-3-a
    │   │   │   ├── page-3-b.md         <-- /level-one/level-two/level-three/page-3-b
    │   │   │   └── page-3-c.md         <-- /level-one/level-two/level-three/page-3-c
    │   │   ├── _index.md               <-- /level-one/level-two
    │   │   ├── page-2-a.md             <-- /level-one/level-two/page-2-a
    │   │   ├── page-2-b.md             <-- /level-one/level-two/page-2-b
    │   │   └── page-2-c.md             <-- /level-one/level-two/page-2-c
    │   ├── _index.md                   <-- /level-one
    │   ├── page-1-a.md                 <-- /level-one/page-1-a
    │   ├── page-1-b.md                 <-- /level-one/page-1-b
    │   └── page-1-c.md                 <-- /level-one/page-1-c
    ├── _index.md                       <-- /
    └── page-top.md                     <-- /page-top

{{% notice note %}}
`_index.md` is required in each folder, it’s your “folder home page”
{{% /notice %}}

## Pages
The theme that we're using defines two types of pages. *Default* and *Chapter*. Both can be used at any level of the documentation, the only difference being layout display.
### Chapters
A **Chapter** displays a page meant to be used as introduction for a set of child pages. Commonly, it contains a simple title and a catch line to define content that can be found under it.
```toml
---
title: Contribute
weight: 2
chapter: true
---

### Chapter 2

# Contribute

Discover how you can contribute!
```
To consider a page as a chapter, set `chapter=true` in the Front Matter of the page.

### Default pages
A **Default** page is any other content page.

```toml
---
date: 2016-04-09T16:50:16+02:00
title: Advanced display configuration options
weight: 40
---

## Advanced configuration options
```

### Content
Now you can add your content (or update existing ones) to the pages that you want. 

## Building the docs website
In order to build and submit your changes, please follow the instructions below:

* Fork the [flogo](https://github.com/TIBCOSoftware/flogo) repo
* Update the docs with your content
* Create a PR against the [flogo](https://github.com/TIBCOSoftware/flogo) repo