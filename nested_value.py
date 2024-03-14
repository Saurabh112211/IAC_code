def get_nested_value(obj, key):
    keys = key.split('/')
    value = obj
    try:
        for k in keys:
            value = value[k]
        return value
    except (KeyError, TypeError):
        return None
        
object1 = {"a": {"b": {"c": "code"}}}
key1 = 'a/b/c'
print(get_nested_value(object1, key1)) 

object2 = {"x": {"y": {"z": "run"}}}
key2 = 'x/y/z'
print(get_nested_value(object2, key2))