<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
        <table class="list">
          <thead>
            <tr>
              <td class="left" colspan="3">通用布局模块</td>
            </tr>
          </thead>
          <tbody>
            <?php if ($extensions) { ?>
            <?php foreach ($extensions as $row) { ?>
            <tr>
              <?php foreach ($row as $item): ?>
              <td class="left"><?php echo $item['name']; ?>
                <div style="float:right;">
                <?php foreach ($item['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?>
                </div>
              </td>
              <?php endforeach ?>
            </tr>
            <?php } ?>
            <?php } ?>
          </tbody>
        </table>

    </div>
  </div>
</div>

<?php echo $footer; ?>