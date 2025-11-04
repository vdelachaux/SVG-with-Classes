<!--BADGES-->
[repo]: SVG-with-Classes
[release-shield]: https://img.shields.io/github/v/release/vdelachaux/[repo]?include_prereleases
[release-url]: https://github.com/vdelachaux/[repo]/releases/latest
![Static Badge](https://img.shields.io/badge/Dev%20Component-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com)
![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)
<br>
[![release][release-shield]][release-url]
<img src="https://img.shields.io/github/downloads/vdelachaux/SVG-with-Classes/total"/>

# SVG with Classes

After creating and using the [4D SVG component](https://doc.4d.com/4Dv19/4D/19/4D-SVG-Component. 100-5461938.en.html), I realized the need to create a more concise, faster, and SVG-like API for managing user interfaces and simplifying SVG image/document manipulation. The main goal was to reduce code complexity for SVG image/document creation and manipulation. 

This repository includes:

* The component source code
* The built and signed component
* A test project that provides code examples and “How do I” guides

The content will be augmented according to my needs but I strongly encouraged you to enrich this project through [pull request](https://github.com/vdelachaux/SVG-with-Classes/pulls). This can only benefit the [4D developer community](https://discuss.4d.com/search?q=4D%20for%20iOS). 

* The `svg` class simplifies the creation and manipulation of the SVG elements thanks to a set of simple functions and some automatisms, and decrease the number of variables needed. 

* The `chart` class is a very succinct implementation of the SVG chart types I needed. More could be done ;-)

For more details on properties and functions, see the class documentation:

* [svg class](SVG-with-Classes/Documentation/Classes/svg.md)
* [chart class](SVG-with-Classes/Documentation/Classes/chart.md)

# <a name="installation">Installation</a>

## ![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)

The component is compatible with the [Project Dependencies](https://developer.4d.com/docs/Project/components#monitoring-project-dependencies) feature. You can easily integrate it into your project by selecting Design > Project Dependencies and adding `vdelachaux/SVG-with-Classes` as the repository address in the dedicated dialog box. I suggest setting the rule to “Follow 4D version.”  **This way, you can benefit from updates over time.**

## Binary databases

Download the component to the `BUILD` folder corresponding to your version of 4D and place it in a `Component` folder near your `.4DB`file.

# <a name="improvments">Improvements and bug fixes</a>

* If you encountered a bug or have a feature request, feel free to create an issue.
However, it is highly appreciated if you [browse and search current issues](https://github.com/vdelachaux/SVG-with-Classes/issues) first.
Found the issue? Go on and join its discussion thread.
Not found? Go on and [create one](https://github.com/vdelachaux/SVG-with-Classes/issues/new).

* We welcome contributions to this repository! To contribute, please follow these steps:

	1. [Fork the repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).
	2. Create a new branch:
	    ```$
	    git checkout -b my-feature-branch
	    ```
	3. Make your changes and commit them:
	    ```$
	    git commit -m "Add my feature"
	    ```
	4. Push to the branch:
	    ```$
	    git push origin my-feature-branch
	    ```
	5. [Create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).
	
	For more details, please refer to our [contributing guidelines](CONTRIBUTING.md).

## License

`SVG with Classes` is licensed under the MIT License See the [LICENSE](./SVG with Classes/LICENSE) file for more details.

## Contact
For any questions or inquiries, please contact the repository owner [@vdelachaux](https://github.com/vdelachaux).

----
`Enjoy the 4th dimension`
