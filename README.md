# Static site builder

This is the collection of scripts that builds my static blog.

It is *very much* a personal hacked-together project.
Every part of it is terrible.
Some of it is unmaintained.
You have been warned.

## How to use

`nix build`.

### The `pdfs` flake

The `pdfs` flake is expected to output a structure such as the following:

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

### The `images` flake

The `images` flake is expected to output a structure such as the following:

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

## License

Code from the Anatole theme is MIT-licenced, and there's a copy next to it.
The content of this website does not yet have a licence, because I haven't thought that far ahead: all rights reserved, you can `git clone` the repository from GitHub, but nothing else.
Contact me if you want to use it for some reason.
