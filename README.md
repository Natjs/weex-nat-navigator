# nat-navigator

    iOS Only (at present)

- [Documentation](http://natjs.com/#/#navigator)
- [Github](https://github.com/natjs/weex-nat-navigator)

## Installation
```
weexpack plugin add nat-navigator
```

```
npm install natjs --save
```

## Usage

Use in weex file (.we)

```html
<script>
import 'Nat' from 'natjs'

Nat.navigator.init({
    fontSize: 24,
    color: '#fff',
    backgroundColor: '#0bc2ee'
})

Nat.navigator.push({
    url: 'js file path'
})

Nat.navigator.pop()

</script>
```

See the Nat [Documentation](http://natjs.com/) for more details.
