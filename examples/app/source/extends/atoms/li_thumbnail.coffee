class Atoms.Atom.LiThumbnail extends Atoms.Atom.Li

  @template = """
    <li class="thumbnail">
      <figure style="background-image: {{url}}"></figure>
      <div>
        <span>when -> {{when}}</span>
        <strong>name -> {{name}}</strong>
        <small>description -> {{description}}</small>
      </div>
    </li>
  """
