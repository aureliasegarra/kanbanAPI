const Card = require('./card');
const List = require('./list');
const Tag = require('./tag');

/** Associations */

// Résumé
// 11 : hasOne, belongsTo (extrêmement rare)
// 1N : belongsTo, hasMany (plus courant)
// NN : belongsToMany x 2

Card.belongsToMany(Tag, {
    as: 'tags',
    through: 'card_has_tag',
    foreignKey: 'card_id',
    otherKey: 'tag_id',
    timestamps: false // pas de updated_at dans la table de liaison
});

Tag.belongsToMany(Card, {
    as: 'cards',
    through: 'card_has_tag',
    foreignKey: 'tag_id',
    otherKey: 'card_id',
    timestamps: false
});

List.hasMany(Card, {
    as: 'cards',
    foreignKey: 'list_id'
});

Card.belongsTo(List, {
    as: 'list',
    foreignKey: 'list_id'
});

module.exports = {Card, List, Tag};