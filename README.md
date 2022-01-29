# Static site builder

This is the collection of scripts that builds my static blog.

## Checking out

The builder is intended to `git subtree` to separate the mechanics of building from the content to be built, though you could simply inline your own content into the repo at the specified locations, or use submodules if you don't care about Nix support.

The subtree checkout is automated using `./checkout.sh`, which you should update to point to your own content.
After `./checkout.sh` has executed, you should be on a new branch called `working`, in which those remote repos have been read in appropriately as subtrees.
When you want to commit changes to this repo, you need to cherry-pick them out onto `main` or similar, so as not to introduce the subtrees to the history of `main`; the `working` branch is created so that it's harder to get confused this way.
At some point, I may write helper scripts to make the workflows sane.

## How to use

I currently maintain two distinct build pipelines that should do the same thing.
I'm in the process of standardising them as much as possible so that the choice boils down to "use Docker or use Nix to get my dependencies in place", with all the actual scripts shared.

* A Nix flake (`./flake.nix`). Invoke using a plain old `nix build` to get the rendered site symlinked to `./result`.
* A shell script (`./build.sh`) which runs a collection of pipelines in Docker images. Invoke using `sh ./build.sh` to get the rendered site in `./public`.

The repository is intended to contain subtrees (see "Checking out" above) which refer to example content:

* `hugo`, which refers to a [Hugo](https://github.com/gohugoio/hugo) static site directory, no tweaks required.
* `pdfs`, which must contain a collection of TeX files and a text file `pdf-targets.txt`.
* `images`, which must contain a collection of folders containing image files, and a text file `image-targets.txt`.
* `meta`, which contains some amount of miscellaneous metadata.

### The `pdfs` folder

The `pdfs` folder is expected to contain a structure such as the following:

```
file1.tex
file2.tex
/pdf-targets.txt
```

The contents of `pdf-targets.txt` is then expected to be, for example:

```
static/Foo/Bar/file1.tex
static/Quux/file2.tex
```

The result of the build will be that PDFs are produced using `pdftex` for each of these TeX files, and then each file (`foo/bar/X.tex`, say) named in the `pdf-targets.txt` file has been copied into the resulting Hugo output directory at that path (`foo/bar/X.tex`) along with its rendered PDF (`foo/bar/X.pdf`).
Note that the build script finds the source TeX file for `foo/bar/X.tex` simply by looking at the basename, i.e. it looks in `pdfs/X.tex` to find `foo/bar/X.tex`.

In the above example, the following files therefore exist in the Hugo output:

```
static/Foo/Bar/file1.tex
static/Foo/Bar/file1.pdf
static/Quux/file2.tex
static/Quux/file2.pdf
```

### The `images` folder

The `images` folder is expected to contain a structure such as the following:

```
FolderName/image1.jpg
FolderName/image1.md
FolderName/image2.png
AnotherFolderName/image1.jpg
image-targets.txt
```

(It is important that images appear only one level deep in directories.)

The contents of `image-targets.txt` is then expected to be, for example:

```
static/images/galleries/FolderName
static/images/galleries/AnotherFolderName
```

The result of the build will be that thumbnails are produced for each of these images, and then each directory (`foo/bar/X`, say) named in the `image-targets.txt` file has been copied into the resulting Hugo output directory at that path (`foo/bar/X`).
Note that the build script finds the source images for `foo/bar/X` simply by looking at the basename, i.e. it looks in `images/X` to find `foo/bar/X`.

In the above example, the following files therefore exist in the Hugo output:

```
static/images/galleries/FolderName/image1.jpg
static/images/galleries/FolderName/image1.md
static/images/galleries/FolderName/image2.png
static/images/galleries/AnotherFolderName/image1.jpg
```

The `.md` files are left untouched, and it's up to your Hugo build to do something sane with them like interpreting them as alt text.

### The `meta` folder

Currently nothing is implemented that uses the `meta` folder.
However, in the immediate future I intend adding support for the following:

* `meta/external-links.txt`: a list of URLs the build process will assert have content in the rendered output. (This is so that if you come across someone linking to your content externally, you can ensure that this link will not break unless your domain moves.)


## Linting

There is a work-in-progress linting script, which is not currently included in the Nix build.
It is intended to be run after `./build.sh`, and it runs a number of checks on the rendered output, such as ensuring that all HTML is syntactically valid.
