resources.json @learn
=====================

#### file

```
{
	"file": ""
}
```

Path to a resource file *e.g. bg@2x.jpg* or another config json file.

#### formats

```
{
	"file": ["music.mp3"]
	"formats": ["mp3", "ogg"]
}
```

Array of available formats of the **file**.

Default file format can be omitted (*mp3* in the example).

#### resolutions

```
{
	"file": ["bg@3x.png"]
	"resolutions": [3, 2, 1, 0.5, 0.25]
}
```

By default *bg@3x.png* file has resolution equal 3 (because the *@3x*).

Image file will be automatically resized into another smaller resolution from the **file**.

Default file resolution can be omitted (*3* in the example).

Specify resolution smaller than 1, if a file is commonly resized into smaller sizes.

#### resources

```
{
	"resolutions": [2, 1, 0.5],
	"resources": {
		"bg": {
			"file": "bg@2x.png"
		},
		"level1": {
			"file": "level1/resources.json",
			"resolutions": [2, 1, 0.5, 0.25]
		}
	}
}
```

Object contained resource id and it's resource object.

All config properties like *resolutions* and *formats* are scoped from the parent object or file.

##### Array notation

```
{
	"resolutions": [2, 1],
	"resources": [
		"bg@2x.png"
	]
}
```
