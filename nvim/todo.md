t 不用用于快捷键的开头，因为t有util的意思，用于motion跳转,所以不能将t作为tab，tag来理解


###update
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

#### 覆盖配置
>工作目录下可以添加.nvim.lua > .nvimrc > .exrc 来覆盖已有的配置
>以上的配置根据优先级,有且仅有一个文件会生效


#### 快捷键
|快捷键|说明|
|---|---|
|`<c-]>`|跳转到tag对应的内容|
|`<c-o>`|跳转后的后退操作|
|`u`|undo|
|`<c-r>`|redo|
|`ZZ`|等价于: `:wq`|
|`:q!`|强制退出|
|`:e!`|强制重新打开|
|`反引号`|是mark的前缀，之前映射为了`~`作为字符大小写切换|
|`.`|有重复上次才做的意思,不应该作为快捷键前缀|
|`o`|可视模式,将块分为4个角,对角跳转|
|`O`|可视模式,将块分为4个角,同line对角跳转|
|`"`|是剪切板的前缀,不可作为快捷键的开头|

