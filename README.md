# nvim-inject
Highlight embedded languages automatically in neovim

## Install

using packer:
```lua
    use({
        'sigmaSd/nvim-inject',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        }
    })
```
    
## Usage

- Add a comment before the string you want to highlight with the language name
- run `Inject` command
- reload the file with `:edit`

![image](https://user-images.githubusercontent.com/22427111/187037000-06113832-5ffe-4dc1-9fa6-e3821e04a04b.png)
![image](https://user-images.githubusercontent.com/22427111/187037016-71a84744-66bf-4c4a-b3b9-b9b2b063a5ae.png)
