# Go Plugin

The go plugin provides some extra niceties for using micro with
the Go programming language. The main thing this plugin does is
run `gofmt` and `goimports` for you automatically. If you would also
like automatically error linting, check out the `linter` plugin.
The plugin also provides `gorename` functionality.

You can run

```
> gofmt
```

or

```
> goimports
```

To automatically run these when you save the file, use the following
options:

* `gofmt`: run gofmt on file saved. Default value: `on`
* `goimports`: run goimports on file saved. Default value: `off`

To use `gorename`, place your cursor over the variable you would like
to rename and enter the command `> gorename newName`.

You also press F6 (the default binding) to open a prompt to rename. You
can rebind this in your `bindings.json` file with the action `go.gorename`.

The go plugin also provides an interface for using `gorename` if you have
it installed. The gorename command behaves in two ways:

* With one argument: `> gorename newname` will rename the identifier
  under the cursor with the new name `newname`.

* With two arguments: `> gorename oldname newname` will rename the old
  identifier with the new one. This uses gorename's syntax for specifying
  the old identifier, so please see `gorename --help` for the details
  for how to specify the variable.
