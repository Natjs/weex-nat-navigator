# nat-navigator

    iOS Only (at present)

## Installation
```
weexpack plugin add nat-navigator
```

```
npm install weex-nat --save
```

## Usage

Use in weex file (.we)

```html
<script>
import 'Nat' from 'weex-nat'

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
