--欢迎页面
local obj = {
    'goolord/alpha-nvim',
    config = function()
        require 'alpha'.setup(require 'alpha.themes.theta'.config)
    end
}
return obj
