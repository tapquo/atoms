# Atoms
## Atomic Development for Modern WebApps
Copyright 2013, Tapquo S.L.



### Qué demonios es Atoms?
Es un proyecto ideado por uno de los fundadores de Tapquo, Javi Jiménez (a.k.a. [@soyjavi](http://twitter.com/soyjavi)) el cual se encontró con el problema que 2 de los frameworks que había desarrollado anteriormente [Lungo](http://lungo.tapquo.com) y [TukTuk](http://tuktuk.tapquo.com) estaban totalmente desacoplados pero reunían funcionalidad similar (y código duplicado).

Con esto, siendo Javi una persona que odia las duplicidades comenzó a estudiar dentro de las especificaciones de [W3C](http://www.w3.org/) algo que le ayudase a crear mejores WebApps, encontró los [WebComponents](https://dvcs.w3.org/hg/webcomponents/raw-file/tip/explainer/index.html), HTMLTemplates, ShadowDOM… pero desgraciadamente todavia son borradores que los navegadores no están dispuestos a implementar (de momento).


### Atomic Design?

El paradigma "Atomic Development" se basa en la gran idea de [Brad Frost](http://bradfrostweb.com) con su [**Atomic Design**](http://bradfrostweb.com/blog/post/atomic-web-design/) , el acercamiento para la reutilización y escalabilidad de nuestros "componentes" es realmente bueno pero por ahora Brad solo ha pensado en el diseño. avi esta pensado en el desarrollador y no solo en el diseño como ha hecho Brad. Lo expresa claramente en una cita que pone en su site:

##### *We’re not designing pages, we’re designing systems of components.* - Stephen Hay

El caso es que una WebApp no solo es diseño debe disponer de lógica y para ello lo que Javi ha pensado es tener comunicado todo el sistema con eventos, de esta manera podrá saber cuando un Atomo, Molécula u organismo tienen que realizar una acción.


### Atoms, Molecules, Organisms…. WTF?!
Si, lo sabemos, eres un desarrollador y no un químico… pero hemos querido basarnos en la nomenclaruta que diseño Brad para que entiendas el concepto. Si no recuerdas tus clases en el instituto, Brad lo refleja muy bien en esta imagen:
![image](http://cdn.tapquo.com/images/atoms/atomic-design-process.png)

De esta manera vamos a considerar que:

* **Atom**: Es el elemento básico de una aplicación por ejemplo `input`, `button`, `ul`, `img`…
* **Molecule**: Es la agrupación de varios atomos y estos se pueden comunicar. Un organismo claro sería un "Search" que une los atomos `label`, `input` y `button`.
* **Organisms**: Es la agrupación de varias moleculas, las cuales tambien pueden comunicarse. Por ejemplo podríamos hablar de un "Header" el cual tiene las moleculas "Navigation" y "Search".
* **Templates**: La idea de un template es crear un andamiaje básico para tus WebApps, sabes que todas las Apps suelen tener secciones parecidas: Login, Navegaciones, Listas … por eso es necesario usar los templates que te facilitará Atom o crear los tuyos propios y ofrecerlos a la comunidad.
* **Pages**: Brad habla de Pages y Javi habla de Apps … pero el concepto es el resultado final de la química de tus atomos.


### Quieres ayudar?
No te pedimos que seas un Alquimista reputado, simplemente que interiorices estos conceptos empieces a estudiar el código que Javi está escribiendo y ayudarle en tu camino a crear un mejor sistema para crear WebApps personalizadas, escabalables y comunicatarias.