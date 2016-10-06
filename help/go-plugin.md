# Go Plugin

The go plugin provides some extra niceties for using micro with
the Go programming language. The main thing this plugin does is
run `gofmt` and `goimports` for you automatically. If you would also
like automatically error linting, check out the `linter` plugin.

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
