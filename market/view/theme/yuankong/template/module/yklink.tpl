
<?php foreach ($links as $key => $item): ?>

    <a target="_blank" href="<?php echo $item['url'] ?>"><?php echo $item['name'] ?></a>
    <?php if (count($links) != $key+1): ?>
    |
    <?php endif ?>
<?php endforeach ?>