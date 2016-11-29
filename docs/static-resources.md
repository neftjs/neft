# Static Resources

Resources like images are handled by the [Resources](/api/resources.html) module.

All resource files are available:
- directly in native applications,
- by the `/static` URI on run *Node* server,
- on demand for browser applications (*Node* server needs to be run).

All config files and resources needs to be stored in the `/static` folder. Create it if needed.

Each resource file has to be declared in a config file.

The main config file is `/static/resources.json` or `/static/resources.yaml`. Both *JSON* and *YAML* formats are supported.

## Config file

Config file needs to define `resources` object with named resources.

Let's create a `background` resource pointing to `default_background.png` file.

```json
{
    "resources": {
        "background": {
            "file": "default_background.png"
        }
    }
}
```

### Image resolutions

Different devices have different resolutions and pixel ratios.

For instance on Apple devices with Retina screens, the pixel ratio is equal `2`. It means, all images needs to be two times bigger to show them sharp, not blurry.

To define an image with different resolutions you have to:
- create a file with a suffix `@Nx`, where `N` is the resolution (e.g. `@2x` for retina, `@3x` for devices with greater pixel ratio),
- defines available resolutions in the `resolutions` array.

Neft automatically determines, which variant of an image should be used.

For instance, if you have an image called `logo.png` and you want to support retina devices:

```json
{
    "resources": {
        "logo": {
            "file": "logo@2x.png",
            "resolutions": [1, 2]
        }
    }
}
```

### Color value

Use `color` instead of `file` to store color value under a name.

```json
{
    "resources": {
        "primary": {
            "color": "#ff00cc"
        }
    }
}
```

## Using resources

Prefix resource name by `rsc:` to use it in styles or views.

To use previously defined `logo` resource, you should specify [Image::source](/api/renderer-image.html#source) as `rsc:logo`.

```javascript
Image {
    source: 'rsc:logo'
}
```
