# Atoms
## Atomic Development for Modern WebApps
Copyright 2013-2014, Javier Jimenez Villar


### What is project *Atoms*?
It is a project created by one of the founders of [Tapquo](http://tapquo.com), Javi Jimenez (aka [@soyjavi](http://twitter.com/soyjavi)) which encountered the problem that two of the frameworks that had been developed previously [Lungo](http://lungo.tapquo.com) and [TukTuk](http://tuktuk.tapquo.com) were completely decoupled and having similar functionality with duplicated code. So, knowing that Javi as person who hates duplication began studying within specification [W3C](http://www.w3.org/) something to help him create better WebApps, found the [WebComponents](https://dvcs.w3.org/hg/webcomponents/raw-file/tip/explainer/index.html) HTMLTemplates, ShadowDOM ... but unfortunately nowadays are only drafts and browsers have not implemented  it.


### Atomic Design?

The paradigm "Atomic Development" is based on the big idea of [Brad Frost](http://bradfrostweb.com) with his [Atomic Design](http://bradfrostweb.com/blog/post/atomic-web-design/), one approach to reuse and scale our "components". AD is really good but Brad just thought of the design context, Javi as a developer thinks in his world (code and code). Both are clearly expresses in this appointment:

***We’re not designing pages, we’re designing systems of components.*** - Stephen Hay

The fact is that a WebApp not only consists of the design must have a business logic and to do that, Javi's thought is to have the whole system connected with the pub/sub pattern, so you can know when an Atom, Molecule or Organism have a certain action.


### Atom, Molecule, Organism… WTF?!
Yes, we know, you're a developer and not an alchemist ... but we wanted to based on the nomenclature of Brad to understand the concept. If you forgot your chemistry classes in high school, Brad teaches you very well in this picture:
![image](http://cdn.tapquo.com/images/atoms/atomic-design-process.png)

In this way we consider that:

* **Atom**: It is the basic element of an Atoms WebApp such as `input`, `button`, `ul`, `img` ...
* **Molecule**: The grouping of several atoms and these can communicate. A clear example would be a `Search` that binds the atoms `label`, `input` and `button`.
* **Organisms**: The grouping of several atoms and molecules, which also can communicate. For example we could speak of a `Header` which holds for example the molecules `Navigation` and `Search`.
* **Templates**: The idea of ​​a template is to create a basic scaffolding for a determinate section of your Atoms WebApp, you know that all Apps often have similar sections: *Login*, *Lists*, *Charts* ... so it is necessary to create and use the templates and provide to the community.
* **Pages**: Brad talks about *Pages* and Javi call it *Systems* ... but the concept is the end result of the chemistry of your atoms, molecules, organisms and templates.


### How to start testing *Atoms*?
Atoms fully developed with [CoffeeScript](http://coffeescript.org) language and its development tools have been used as [NodeJS](http://nodejs.org) and [Grunt](http://gruntjs.com). So if you don't have these applications installed, please install first NodeJS and then type the following commands:

```
npm install -g coffee-script
npm install -g grunt-cli
```

Now you can download the project code and get all the necessary NPM modules:

```
git clone https://github.com/tapquo/atoms.git my-atoms
git submodule foreach git pull origin master
npm install
```

Once we have our computer ready, just you only need GruntJS which have already scheduled tasks:

* Test Library with Jasmine & 
* Compile Library in debug mode
* Uglify Library for production mode
* Process and minify stylus stylesheets

You can run the process `grunt` but we recommend you use `grunt watch` to run only the necesary tasks.


### Your turn, make *Atoms* the best tool 
We do not want you to be a reputed Alchemist, simply internalize these concepts and begin to study the new code that Javi is writing every day and help you on your way to creating a better system for creating custom WebApps, escabalables and community.

This is opensource, so feel free to fork this project to help us create a better tool. All source code is developed with CoffeeScript and Stylus, but don’t worry we worship clean-code so you can quickly get to make your own modifications in it.https://github.com/tapquo/atoms


### Licensing ###
Atoms is licensed under MIT licensed. See [LICENSE.md](https://github.com/tapquo/atoms/blob/master/LICENSE.md) file for more information.
