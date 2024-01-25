# Property types

## properties_bool_type

### default


```lua
boolean?
```
Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### type


```lua
"bool"
```



## properties_button_type

### callback


```lua
function
```

The function called when the button is pressed.

### default


```lua
any
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### type


```lua
"button"
```


---

## properties_editable_list_type

### default


```lua
any
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### editable_list_type


```lua
EditableListType?
```

The type of the editable list. Defaults to "strings".

### filter


```lua
string?
```

The filter for the list.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### type


```lua
"editable_list"
```


---

## properties_float_type

### default


```lua
number?
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### max


```lua
integer
```

The maximum value of the property.

### min


```lua
integer
```

The minimum value of the property.

### name


```lua
string
```

The name of the property.

### step


```lua
integer
```

With which step the property can be changed.

### type


```lua
"float"|"float_slider"
```


---

## properties_font_type

### default


```lua
integer?
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### type


```lua
"font"
```


---

## properties_int_type

### default


```lua
integer?
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### max


```lua
integer
```

The maximum value of the property.

### min


```lua
integer
```

The minimum value of the property.

### name


```lua
string
```

The name of the property.

### step


```lua
integer
```

With which step the property can be changed.

### type


```lua
"int"|"int_slider"
```


---

## properties_list_type

### combo_format


```lua
ComboFormat?
```

The format of the combo. Defaults to "string".

### combo_type


```lua
ComboType?
```

The type of the combo. Defaults to "editable".

### default


```lua
any
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### options


```lua
any
```

The options that the list has.

### source_options


```lua
table<SourceType, boolean>?
```

Add existing sources to the list. Filter for a specific source type using `true` and `falls`. Use `all` to add all sources.

### type


```lua
"list"
```


---

## properties_number_type

### default


```lua
integer?
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### type


```lua
"color"|"framerate"
```


---

## properties_path_type

### default


```lua
string?
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### filter


```lua
string?
```

The filter for the path.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### path_type


```lua
PathType?
```

The type of the path. Defaults to "file".

### type


```lua
"path"
```


---

## properties_text_type

### default


```lua
string?
```

Optional. The default value of the property.

### description


```lua
string?
```

Optional. The description of the property.

### id


```lua
string
```

The id of the property.

### name


```lua
string
```

The name of the property.

### text_type


```lua
TextType?
```

The type of the text. Defaults to "default".

### type


```lua
"text"
```